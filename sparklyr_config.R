Sys.setenv(SPARK_HOME="/opt/spark")
Sys.setenv(JAVA_HOME="/opt/jdk8")
library(sparklyr)
spark_context <- function(memory="4G", instances=1, cores=2, master="local[*]"){
  spark_session <- spark_connect(
    master=master,
    app_name="Ja'La dh Jin : Sparklyr",
    spark_home=Sys.getenv("SPARK_HOME"),
    config=list(
      "spark.executor.instances"=instances,
      "spark.executor.cores"=cores,
      "spark.executor.memory"=memory,
      "spark.executor.extraJavaOptions"="-XX:+UseG1GC -XX:G1HeapRegionSize=32M -XX:InitiatingHeapOccupancyPercent=35"
    )
  )
  return(spark_session)
}
