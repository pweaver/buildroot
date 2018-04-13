Docker container for [buildroot](https://buildroot.org/).

# Getting Started

Create a Dockerfile and a `FROM pweaver/buildroot:latest` or `FROM
pweaver/buildroot:{buildroot-version}` or `docker pull "pweaver/buildroot"`

Add any files used for building your buildroot image and run 
```
docker run
    -it
    -rm
    -v $(pwd)/data:/buildroot/data
    -v $(pwd)/external:/buildroot/external
    -v $(pwd)/images:/buildroot/images
    -v $(pwd)/rootfs_overlay:/buildroot/rootfs_overlay
    pweaver/buildroot"
    [command]
```

You can look at the buildroot READMEs, add your configs to external, and build
while setting `make BR2_EXTERNAL=/buildroot/external` or setting `BR2_DEFCONFIG`.

You can also use the docker only mounts by adding files in the Dockerfile and not mounting volumes.
