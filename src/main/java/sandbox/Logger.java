package sandbox;

import org.slf4j.LoggerFactory;
import ru.yandex.qatools.camelot.api.annotations.Filter;
import ru.yandex.qatools.camelot.api.annotations.Processor;

@Filter(instanceOf = {String.class})
public class Logger {
    final org.slf4j.Logger logger = LoggerFactory.getLogger(getClass());

    @Processor
    public String logString(String event) {
        logger.info("Got event {}", event);
        return event + "-logged";
    }
}