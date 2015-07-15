package sandbox;

import ru.yandex.qatools.camelot.api.AggregatorRepository;
import ru.yandex.qatools.camelot.api.EventProducer;
import ru.yandex.qatools.camelot.api.annotations.Input;
import ru.yandex.qatools.camelot.api.annotations.Repository;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Response;

@Path("/collect")
public class InputResource {

    @Input
    public EventProducer input;

    @Repository
    private AggregatorRepository<State> repo;

    @GET
    @Path("put")
    public Response put(@QueryParam("key") String key) {
        input.produce(key);
        return Response.ok("OK").build();
    }

    @GET
    @Path("get")
    @Produces("application/json")
    public State get(@QueryParam("key") String key) {
        return repo.get(key);
    }
}