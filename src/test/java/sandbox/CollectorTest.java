package sandbox;

import org.apache.camel.component.mock.MockEndpoint;
import org.junit.Test;
import org.junit.runner.RunWith;
import ru.yandex.qatools.camelot.test.*;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;
import static org.mockito.Matchers.any;
import static org.mockito.Matchers.eq;
import static org.mockito.Mockito.timeout;
import static org.mockito.Mockito.verify;

/**
 * @author Ilya Sadykov
 */
@RunWith(CamelotTestRunner.class)
public class CollectorTest {
    @PluginMock
    Collector collector;

    @AggregatorState(Collector.class)
    AggregatorStateStorage storage;

    @EndpointPluginInput(Collector.class)
    MockEndpoint collectorEP;

    @Helper
    TestHelper helper;

    @Test
    public void testMessageIsReceivedByAggregator() throws InterruptedException {
        collectorEP.expectedMessageCount(3);
        helper.send("body1");
        helper.send("body1");
        helper.send("body1");
        collectorEP.assertIsSatisfied(2000);
        verify(collector, timeout(2000).times(3)).collect(any(State.class), eq("body1-logged"));
        assertThat(((State) storage.getActual("body1-logged")).index, equalTo(3L));
    }
}