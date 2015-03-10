# qreplay

This is a simple tool to drive capturing, saving, and replaying HTTP requests. It depends on `pcap_tools`, `tshark`, `dumpcap`, and `httperf`.

## Use

```shell
gem install qreplay
qreplay [capture|replay|transform|capture_only] [options]
```

Options:
```
    --capture-time, -c <f>:   Capture time length in seconds (default: 60.0)
            --port, -p <i>:   Capture/replay traffic to port (default: 80)
            --host, -h <s>:   Replay host (default: 0.0.0.0)
         --req-sec, -r <i>:   Requests per second for replays (default: 20)
  --total-requests, -t <i>:   Total replay requests to send (default: 10000)
    --capture-file, -a <s>:   Output file (default: ./qreplay.sesslog)
   --tshark-binary, -s <s>:   TShark binary file location (default: tshark)
  --dumpcap-binary, -d <s>:   dumpcap binary file location (default: dumpcap)
       --pcap-file, -f <s>:   Temporary intermediate pcap file path (default: ./qreplay.pcap)
  --httperf-binary, -e <s>:   httperf binary file location (default: httperf)
                --help, -l:   Show this message
```

## Example

You want to capture traffic on a live web server. On the remote machine run:

```
qreplay capture --capture-time 60 --port 80
```

This will use `tshark` to capture TCP traffic to/from port 80 for 60 seconds, stitch together HTTP requests from the TCP traffic, and save requests to `./qreplay.sesslog`. If you observe this file you will notice that each request line contains an HTTP method, path, and body in a format acceptable to `httperf`.

You can then replay with:

```
qreplay replay --host 127.0.0.1 --port 80 --req-sec 50
```

To replay these requests to the local server at port 80 at a rate of 50 per second.

## Installing

Mac OS X (homebrew):
```
gem install qreplay
brew install wireshark httperf
```

Yum package manager:
```
gem install qreplay
yum install wireshark httperf
```

## License

The qreplay copyright is owned by Old School Industries LLC. We've licensed it under the MIT License, which can be found in `LICENCE.md`.

## Thanks

Thanks to Bertrand Paquet for developing pcap tools and licensing it under the Apache 2 license. You can find more about pcap_tools [here](https://github.com/bpaquet/pcap_tools).

