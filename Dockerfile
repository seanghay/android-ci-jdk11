FROM openjdk:11-jdk

ENV ANDROID_COMPILE_SDK=30
ENV ANDROID_BUILD_TOOLS=30.0.3
ENV ANDROID_SDK_TOOLS=6858069_latest

RUN apt-get --quiet update --yes
RUN apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1
RUN apt-get -qq install curl
RUN wget --quiet --output-document=android-sdk.zip https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_TOOLS}.zip
RUN unzip -d android-sdk-linux android-sdk.zip
RUN echo y | android-sdk-linux/cmdline-tools/bin/sdkmanager --sdk_root=. "platforms;android-${ANDROID_COMPILE_SDK}" >/dev/null
RUN echo y | android-sdk-linux/cmdline-tools/bin/sdkmanager --sdk_root=. "platform-tools" >/dev/null
RUN echo y | android-sdk-linux/cmdline-tools/bin/sdkmanager --sdk_root=. "build-tools;${ANDROID_BUILD_TOOLS}" >/dev/null

ENV ANDROID_SDK_ROOT=$PWD
ENV PATH=$PATH:$PWD/platform-tools/

RUN yes | android-sdk-linux/cmdline-tools/bin/sdkmanager --sdk_root=. --licenses

ENV GRADLE_USER_HOME=$PWD/.gradle
