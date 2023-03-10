**Deploy a registry server**
Before you can deploy a registry, you need to install Docker on the host. A registry is an instance of the registry image, and runs within Docker.

This topic provides basic information about deploying and configuring a registry. For an exhaustive list of configuration options, see the [configuration reference](https://docs.docker.com/registry/configuration/).

If you have an air-gapped datacenter, see [Considerations for air-gapped registries](https://docs.docker.com/registry/deploying/#considerations-for-air-gapped-registries).

**Run a local registry**
Use a command like the following to start the registry container:

```docker run -d -p 5000:5000 --restart=always --name registry registry:2``` 

The registry is now ready to use.

**Copy an image from Docker Hub to your registry**
You can pull an image from Docker Hub and push it to your registry. The following example pulls the ubuntu:16.04 image from Docker Hub and re-tags it as my-ubuntu, then pushes it to the local registry. Finally, the ubuntu:16.04 and my-ubuntu images are deleted locally and the my-ubuntu image is pulled from the local registry.

1. Pull the ubuntu:16.04 image from Docker Hub.
   
   ```docker pull ubuntu:16.04``` 

 2. Tag the image as localhost:5000/my-ubuntu. This creates an additional tag for the existing image. When the first part of the tag is a hostname and port, Docker interprets this as the location of a registry, when pushing.  
   
   ```docker tag ubuntu:16.04 localhost:5000 my-ubuntu``` 

3. Push the image to the local registry running at localhost:5000:
   
  ```docker push localhost:5000/my-ubuntu```

4. Remove the locally-cached ubuntu:16.04 and localhost:5000/my-ubuntu images, so that you can test pulling the image from your registry. This does not remove the localhost:5000/my-ubuntu image from your registry.

```docker image remove ubuntu:16.04```
```docker image remove localhost:5000/my-ubuntu  ```

5. Pull the localhost:5000/my-ubuntu image from your local registry.

```docker pull localhost:5000/my-ubuntu``` 

**Stop a local registry**
To stop the registry, use the same docker container stop command as with any other container.

```docker container stop registry```

To remove the container, use docker container rm.

```docker container stop registry && docker container rm -v registry```

**Basic configuration**
To configure the container, you can pass additional or modified options to the docker run command.

The following sections provide basic guidelines for configuring your registry. For more details, see the [registry configuration reference](https://docs.docker.com/registry/configuration/).

**Start the registry automatically**
If you want to use the registry as part of your permanent infrastructure, you should set it to restart automatically when Docker restarts or if it exits. This example uses the --restart always flag to set a restart policy for the registry.

```docker run -d \ -p 5000:5000 \ --restart=always \ --name registry \ registry:2 ```

**Customize the published port**
If you are already using port 5000, or you want to run multiple local registries to separate areas of concern, you can customize the registry???s port settings. This example runs the registry on port 5001 and also names it registry-test. Remember, the first part of the -p value is the host port and the second part is the port within the container. Within the container, the registry listens on port 5000 by default.

```docker run -d \ -p 5001:5000 \ --name registry-test \ registry:2``` 

If you want to change the port the registry listens on within the container, you can use the environment variable REGISTRY_HTTP_ADDR to change it. This command causes the registry to listen on port 5001 within the container:

```docker run -d \ -e REGISTRY_HTTP_ADDR=0.0.0.0:5001 \ -p 5001:5001 \ --name registry-test \ registry:2```


















 
