# labs
The Local Labs for praciticing the Lab/Test on VM for Architectures, e.g. Microservices, Performance ...
================================================================================

This is a Test Lab for building a Digital Bank, using Microservices, Java Spring Boot as apps
    and using RabbitMQ as broker, Redis Cache, PostgreSQL ...
The BE will have main application as http://api.digital.bank.labs
The FE will be 
    - ReactJS UI, deployed in https://digital.bank.labs
    - Angular UI, deployed in https://angular.digital.bank.labs

We have the project structure as following :
- /infra : The scripts for building infrastructure, using Terraform, SSH, Ansible, ... 
    to provision VM Ubuntu 24.04 LTS using Multipass for quickly launch in local testing
- /backend : The BE side including apis, service configuration, redis, postres scripts, ...
- /react : The FE side for building UIs in ReactJS
- /angular: The FE side for building UI in Angular

All deployment should be version like this x.y.z
    x : Major
    y : Minor
    z : The fixing for patches for current x.y. version
So we will have big changes for 1.0.0, and then 2.0.0
    for backward-compability, we can reuse APIs between minor versions

The DB will be migrated by flyway manual using Docker, not inside the SourceCodes
    - /api/dbs/*.sql