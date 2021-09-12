## Android CI JDK 11 Docker Image

[![Publish Docker Image](https://github.com/seanghay/android-ci-jdk11/actions/workflows/publish.yml/badge.svg)](https://github.com/seanghay/android-ci-jdk11/actions/workflows/publish.yml)

- Android Gradle Plugin 7.0
- API 30
- Node.js 14 preinstalled


## Docker

```bash
docker pull ghcr.io/seanghay/android-ci-jdk11:latest
```

## GitLab CI/CD
```yml
image: ghcr.io/seanghay/android-ci-jdk11:latest

before_script:
    - chmod +x ./gradlew
    
stages:
    - build

cache:
  paths:
    - .gradle/wrapper
    - .gradle/caches

assembleDebug:
    stage: build
    script:
        - ./gradlew assembleDebug
        - cp app/build/outputs/apk/debug/app-debug.apk app-debug.apk
    artifacts:
        paths:
            - app-debug.apk
           
```
