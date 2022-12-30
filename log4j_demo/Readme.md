# Log4J Similuation

In this repository we have a Spring Boot application which has log4j dependency. We will detect the vulnurabilities in this application.

# Trivy Plugin

In extensions install the Trivy Plugin and scan the image.

# Scanning a Docker Image

There is also a dockerfile for this application. This dockerfile is far away from being ideal. We will improve it. But first build the image using the command below:

```
docker build -t my_vulnerable_image .
```

Scan the image using Trivy

```
docker run \
    --rm -it \
    -v /var/run/docker.sock:/var/run/docker.sock \
    aquasec/trivy image \
    my_vulnerable_image
```  
