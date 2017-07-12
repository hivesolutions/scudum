# Fun Stuff

Random set of fun scripts to enjoy the Scudum experience as explore it.

## IPerf

```
scu install iperf3
iperf3 -s
iperf3 -c host.domain
```

## HTop

```
scu install htop
```

## Docker

```
scu install docker
cgroupfs.mount
dockerd -s overlay -g /pst/lib/docker < /dev/null &> /dev/null &
docker pull ubuntu
docker run -i -t ubuntu /bin/bash
```
