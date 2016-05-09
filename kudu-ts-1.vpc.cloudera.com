kuduMasterAddresses: ["localhost"]
kuduTSInstance: "ktsd"

server:
  type: default
  applicationContextPath: "/api"
  applicationConnectors:
    - type: http
      port: 4242

logging:
  level: INFO

  appenders:
    - type: console
    - type: file
      threshold: DEBUG
      logFormat: "%-6level [%d{HH:mm:ss.SSS}] [%t] %logger{5} - %X{code} %msg %n"
      currentLogFilename: /tmp/application.log
      archivedLogFilenamePattern: /tmp/application-%d{yyyy-MM-dd}-%i.log.gz
      archivedFileCount: 7
      timeZone: UTC
      maxFileSize: 10MB

bench:
  ktsdHost: "kudu-ts-1.vpc.cloudera.com"
  ktsdPort: 4242
  #metrics: ["loadavg.1min", "rss"]
  #tags:
    #host: ["web01", "web02", "web03",
           #"db01", "db02", "db03"]
    #dc: ["dc01", "dc02", "dc03"]

  metrics: ["foo"]
  tags:
    foo: ["bar"]
  sampleFrequency: 10
  httpClient:
    timeout: "10s"
    minThreads: 1
    maxThreads: 128
    workQueueSize: 8
    gzipEnabled: true
    gzipEnabledForRequests: true
    chunkedEncodingEnabled: true
