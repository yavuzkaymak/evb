# Secure Connection Simulation

In this simulation we will run two instances of Grafana, one with http and another with https. We will intercept the traffic with wireshark.

## Tools needed

- docker
- tshark 

### tshark Installation:

- Ubuntu/Debian
```
sudo apt update && sudo apt install -y tshark
```

## Unsecure Connection 

- First spin up Grafana with http connection

```
docker run --rm -d --name grafana -p 3000:3000 grafana/grafana
```

- Capture the traffic on loopback

```
sudo tshark -i lo -x -f \
port 3000 and tcp[((tcp[12:1] & 0xf0) >> 2):4] = 0x504f5354" > out.pcap
```

- On browser, open http://localhost:3000 enter admin for user and password.

- Go back to the terminal, you can stop tshark with ctrl-c

- Look through the out.pcap file and find the password and user name in plain text

```
less out.pcap
```

- Stop the grafana container

```
docker kill grafana
```

## Secure Connection

- Build the https enabled grafana

```
docker build -t secured_grafana .
```

- Take a look at the [Dockerfile](Dockerfile)

    - from line 5 to 7 we are generating self-signed  certificate
    - in line 12 we are coping the certificate and its key to grafana
    - in line 13 we are overwriting the grafana configuration with the [grafana.ini](./contrib/grafana.ini) with https enabled.

- Start the new grafana instance 

```
docker run --rm -p 3000:3000 -d --name secured_grafana secured_grafana
```

- Start capturing once again:

```
sudo tshark -i lo -x -f \
port 3000 and tcp[((tcp[12:1] & 0xf0) >> 2):4] = 0x504f5354" > out.pcap
```

- Open in your browser https://localhost:3000
- As the certificates are self-signed your browser will show a security warning, ignore it and continue.
- Enter the same grafana username and password before
- Go back to your terminal stop tshark with ctrl-c
- Examine though the out.pcap file with cat. You won't be able to see the password and username in plain text
- Stop the grafana container:
```
docker kill secure_grafana
```
