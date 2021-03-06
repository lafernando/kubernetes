import ballerina/http;
import ballerinax/kubernetes;

@kubernetes:Deployment {
    livenessProbe: true,
    namespace: "ballerina"
}
@kubernetes:Ingress {
    hostname: "abc.com"
}
@kubernetes:Service { name: "hello" }
listener http:Listener helloEP = new(9090);

@http:ServiceConfig {
    basePath: "/helloWorld"
}
service helloWorld on helloEP {
    resource function sayHello(http:Caller outboundEP, http:Request request) {
        http:Response response = new;
        response.setTextPayload("Hello, World from service helloWorld ! \n");
        _ = outboundEP->respond(response);
    }
}
