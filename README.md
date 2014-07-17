# qreplay

This is a simple tool to drive capturing, saving, and replaying HTTP requests. It depends on `tshark`, `dumpcap`, and `httperf`.

## Use

```shell
gem install qreplay
qreplay [capture|replay] [options]
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
