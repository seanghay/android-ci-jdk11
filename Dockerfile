FROM openjdk:11-jdk

MAINTAINER Seanghay

WORKDIR /root

ENV ANDROID_COMPILE_SDK=30
ENV ANDROID_BUILD_TOOLS=30.0.3
ENV ANDROID_SDK_TOOLS=6858069_latest

# Install packages
RUN apt-get --quiet update --yes
RUN apt-get --quiet install --yes wget tar unzip lib32stdc++6
RUN apt-get -qq install curl

# Node.js
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get --quiet install nodejs --yes
RUN apt-get --quiet install gcc g++ make --yes

RUN wget --quiet --output-document=android-sdk.zip https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_TOOLS}.zip

RUN mkdir -p android-sdk-linux/cmdline-tools

RUN unzip -d android-sdk-linux/cmdline-tools android-sdk.zip

# the folder should be `android-sdk-linux/cmdline-tools/tools`. (I have no idea why Google did this!)
RUN mv android-sdk-linux/cmdline-tools/cmdline-tools android-sdk-linux/cmdline-tools/tools

# Use `ANDROID_SDK_ROOT` instead of `ANDROID_HOME`. `ANDROID_HOME` is deprecated
ENV ANDROID_SDK_ROOT=$PWD/android-sdk-linux

RUN echo y | android-sdk-linux/cmdline-tools/tools/bin/sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}" >/dev/null
RUN echo y | android-sdk-linux/cmdline-tools/tools/bin/sdkmanager "platform-tools" >/dev/null
RUN echo y | android-sdk-linux/cmdline-tools/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}" >/dev/null

ENV PATH=$PATH:$PWD/android-sdk-linux/platform-tools/

# Accept all licenses
RUN yes | android-sdk-linux/cmdline-tools/tools/bin/sdkmanager --licenses

# gradle cache directory
ENV GRADLE_USER_HOME=$PWD/.gradle
