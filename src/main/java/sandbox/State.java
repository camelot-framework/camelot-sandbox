package sandbox;

import java.io.Serializable;

/**
 * @author Ilya Sadykov
 */
public class State implements Serializable {
    public long lastUpdated = 0L;
    public long index = 0L;
    public long timerIndex = 0L;
    public String key;

    @Override
    public String toString() {
        return "State{" +
                "lastUpdated=" + lastUpdated +
                ", index=" + index +
                ", timerIndex=" + timerIndex +
                ", key='" + key + '\'' +
                '}';
    }
}
