NSLW.PL: Netscreen Log Watch, this application converts a screenos syslog file into a flow report.  For instance:

./nslw8.pl

NSLW = NetScreen Log Watch

Usage: nslw <flag = src|dst|bth|fwf|fwo> <file>

flags:
        src = print source IP, protocol, and count
        dst = print destination IP, protocol, and count
        bth = print source & destination IP, protocol, and count
        fwo = print only firewall rules and hit count
        fwf = print bth, and firewall:policy_id

./nslw8.pl src stest.log

172.17.27.26    dns     4

172.17.27.27    dns     2

172.17.27.56    dns     6

172.17.27.70    dns     20

172.17.27.92    dns     4

172.17.27.93    dns     2
172.17.27.95    dns     2
172.17.27.98    dns     2


./nslw8.pl bth stest.log

./nslw8.pl bth stest.log
172.17.27.26    10.2.10.50      dns     4
172.17.27.27    10.2.10.50      dns     2
172.17.27.56    10.2.52.61      dns     6
172.17.27.70    10.2.52.30      dns     20
172.17.27.92    10.2.52.61      dns     4
172.17.27.93    10.2.52.61      dns     2
172.17.27.95    10.2.52.61      dns     2
172.17.27.98    10.2.52.61      dns     2

./nslw8.pl dst stest.log
10.2.10.50      dns     6
10.2.52.30      dns     20
10.2.52.61      dns     16

./nslw8.pl fwo stest.log
DC-TB-FW-01:341      16
DC-TB-FW-01:343      26

./nslw8.pl fwf stest.log
172.17.27.26    10.2.10.50      dns     DC-TB-FW-01:343      4
172.17.27.27    10.2.10.50      dns     DC-TB-FW-01:343      2
172.17.27.56    10.2.52.61      dns     DC-TB-FW-01:341      6
172.17.27.70    10.2.52.30      dns     DC-TB-FW-01:343      20
172.17.27.92    10.2.52.61      dns     DC-TB-FW-01:341      4
172.17.27.93    10.2.52.61      dns     DC-TB-FW-01:341      2
172.17.27.95    10.2.52.61      dns     DC-TB-FW-01:341      2
172.17.27.98    10.2.52.61      dns     DC-TB-FW-01:341      2











