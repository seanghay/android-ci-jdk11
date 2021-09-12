FROM openjdk:11-jdk

MAINTAINER Seanghay

ENV ANDROID_COMPILE_SDK=30
ENV ANDROID_BUILD_TOOLS=30.0.3
ENV ANDROID_SDK_TOOLS=6858069_latest

# Install packages
RUN apt-get --quiet update --yes
RUN apt-get --quiet install --yes wget tar unzip lib32stdc++6 
RUN apt-get -qq install curl

RUN wget --quiet --output-document=android-sdk.zip https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_TOOLS}.zip

RUN unzip -d android-sdk-linux android-sdk.zip

RUN echo y | android-sdk-linux/cmdline-tools/bin/sdkmanager --sdk_root=$PWD "platforms;android-${ANDROID_COMPILE_SDK}" >/dev/null
RUN echo y | android-sdk-linux/cmdline-tools/bin/sdkmanager --sdk_root=$PWD "platform-tools" >/dev/null
RUN echo y | android-sdk-linux/cmdline-tools/bin/sdkmanager --sdk_root=$PWD "build-tools;${ANDROID_BUILD_TOOLS}" >/dev/null

ENV ANDROID_HOME=$PWD/android-sdk-linux

ENV PATH=$PATH:$PWD/android-sdk-linux/platform-tools/

# accept the SDK licenses
RUN yes | android-sdk-linux/tools/bin/sdkmanager --sdk_root=$PWD --licenses

ENV GRADLE_USER_HOME=$PWD/.gradle
