# LTE-Router-Huawei-B618s-22d
bash scripts to query status information and reset the router
## Scripts
### getDynamicInfo
retrieves properties from the router, which change frequently (e.g. the number of received bytes)
the data is stored in XML files like this:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<response>
<CurrentConnectTime>1586</CurrentConnectTime>
<CurrentUpload>126997313</CurrentUpload>
<CurrentDownload>319100864</CurrentDownload>
<CurrentDownloadRate>52</CurrentDownloadRate>
<CurrentUploadRate>135</CurrentUploadRate>
<TotalUpload>11960851325</TotalUpload>
<TotalDownload>69832154477</TotalDownload>
<TotalConnectTime>377385</TotalConnectTime>
<showtraffic>1</showtraffic>
</response>
```
and also parsed into files which can be inclused in bash scripts:
```bash
TotalUpload=11960814672
TotalDownload=69832083539
CurrentConnectTime=1526
CurrentDownloadRate=0
CurrentUploadRate=0
rsrq=-9
rsrp=-88
rssi=-67
sinr=9
band=3
cell_id=35065491
```
### getStaticInfo
retrieves properties from the router, which change infrequently (e.g. the IMEI)
the data is stored in XML files like this:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<response>
<NetworkMode>03</NetworkMode>
<NetworkBand>3FFFFFFF</NetworkBand>
<LTEBand>800C5</LTEBand>
</response>
```
### restart
causes the router to perform a reset
## Setup
* set the IP address or name of the router in property `HOST` of file `base`
* set the directory, in which the files shall be stored in property `DIR` of file `base`

***use a dedicated directory for this, because its contents will be deleted!***
* set the name of the user, which shall be used to log into the router in property `USER` of file `login`
* set the password, which shall be used to log into the router in property `PASS` of file `login`
### Requirements
like most bash scripts, some tools are needed for these scripts:
* wget
* base64
* sha256sum
## Monitoring
script `pushLTEStatus`can be used to push the values to [Prometheus](https://prometheus.io/). It creates a `.prom` file which can be read by [node_exporter](https://prometheus.io/download/#node_exporter). node exported has to be started with the textfile collector enabled (e.g. `-collectors.enabled textfile -collector.textfile.directory /var/spool/prometheus`)
