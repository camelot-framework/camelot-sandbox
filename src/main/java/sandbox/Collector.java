package sandbox;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import ru.yandex.qatools.camelot.api.annotations.Aggregate;
import ru.yandex.qatools.camelot.api.annotations.AggregationKey;
import ru.yandex.qatools.camelot.api.annotations.Filter;
import ru.yandex.qatools.camelot.api.annotations.OnTimer;
import ru.yandex.qatools.fsm.annotations.FSM;
import ru.yandex.qatools.fsm.annotations.OnTransit;
import ru.yandex.qatools.fsm.annotations.Transit;
import ru.yandex.qatools.fsm.annotations.Transitions;

import static java.lang.System.currentTimeMillis;

@Aggregate
@Filter(instanceOf = {String.class})
@FSM(start = State.class)
@Transitions(@Transit(on = String.class))
public class Collector {
    final Logger logger = LoggerFactory.getLogger(getClass());

    @OnTransit
    public void collect(State state, String event) throws InterruptedException {
        state.lastUpdated = currentTimeMillis();
        state.key = event;
        state.index++;
        logger.info("New index {}={}...", state.key, state.index);
    }

    @OnTimer(cron = "*/10 * * * * ?", readOnly = false, skipIfNotCompleted = true)
    public void updateTimerState(State state) {
        state.timerIndex++;
        logger.info("Updating timer state....{}={}={}", state.key, state.index, state.timerIndex);
    }

    @OnTimer(cron = "*/10 * * * * ?", perState = false)
    public void onTimer() {
        logger.info("I'm master Quartz!");
    }

    @AggregationKey
    public String key(String event) {
        return event;
    }
}