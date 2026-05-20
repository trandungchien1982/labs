# labs
The Local Labs for praciticing the Lab/Test on VM for Architectures, e.g. Microservices, Performance ...

The Basic Environment:
    + Ubuntu 24.04 LTS, deploy by Multipass
    + Java
    + Docker
    + Python3
    + Git, Maven, Gradle, ...
    + K3d, Helm, ...

- We will have some VMs for deploying specific services : 
  - vm-dbs : For DBMS:
    - PostreSQL, 5432
    - MySQL, 3306
    - MongoDB, {...}
  - vm-services: For Services, AuthServer, ...
    - redis
    - rabbitmq
    - keycloak (AuthServer)
  - vm-logs: For LogManagement
    - grafana
    - loki
  - vm-dev
  - vm-qa
  - vm-stg
  