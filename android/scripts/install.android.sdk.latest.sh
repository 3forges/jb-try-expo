#!/bin/bash

# https://developer.android.com/studio/preview?hl=fr

# curl -L https://developer.android.com/studio/preview?hl=fr -O ./android.sdk.14.exe.msi.exe


export ANDROID_SDK_VERSION=${ANDROID_SDK_VERSION:-"9477386_latest"}
export ANDROID_SDK_OS=${ANDROID_SDK_OS:-"win"}


mkdir ./temp_install_and_sdk_${ANDROID_SDK_VERSION}/

cd ./temp_install_and_sdk_${ANDROID_SDK_VERSION}/


curl -LO https://dl.google.com/android/repository/commandlinetools-${ANDROID_SDK_OS}-${ANDROID_SDK_VERSION}.zip

# --- 
unzip ./commandlinetools-win-9477386_latest.zip -d peekathat/
ls -alh peekathat/
ls -alh peekathat/cmdline-tools/
ls -alh peekathat/cmdline-tools/bin

export PESTO_DROID_INSTALL_PATH=${HOME}/.pesto/.android/.sdk
mkdir -p ${PESTO_DROID_INSTALL_PATH}/tools/
cp -fR $(pwd)/peekathat/cmdline-tools/* ${PESTO_DROID_INSTALL_PATH}/tools/
rm -fr $(pwd)/peekathat

export ANDROID_HOME=${PESTO_DROID_INSTALL_PATH}
export ANDROID_SDK_ROOT=${PESTO_DROID_INSTALL_PATH}/tools
export ANDROID_SDK_ROOT=${PESTO_DROID_INSTALL_PATH}
unset ANDROID_SDK_ROOT


# ---
# I'm not sure yet if this 'cmdline-tools' folder should or not exist
# mkdir -p  ${PESTO_DROID_INSTALL_PATH}/cmdline-tools/latest/
# cp -fR ${ANDROID_HOME}/tools/* ${ANDROID_HOME}/cmdline-tools/latest/
# ls -alh ${ANDROID_HOME}/cmdline-tools/latest/



ls -alh ${ANDROID_HOME}/tools/
ls -alh ${ANDROID_HOME}/tools/bin/
ls -alh ${ANDROID_HOME}/platform-tools/ || true
export PATH="$PATH:${ANDROID_HOME}/tools/bin/:${ANDROID_HOME}/tools/:${ANDROID_HOME}/platform-tools/"

echo '# ---- ---- ---- ---- ---- ---- ---- ' | tee -a ~/.bashrc
echo '# ---- Pesto APp Mobile App Dev Env' | tee -a ~/.bashrc
echo '# ---- ---- ---- ---- ---- ---- ---- ' | tee -a ~/.bashrc
echo 'export ANDROID_HOME=${HOME}/.pesto/.android/.sdk' | tee -a ~/.bashrc
echo 'export PATH="$PATH:${ANDROID_HOME}/tools/bin/:${ANDROID_HOME}/tools/:${ANDROID_HOME}/platform-tools/"' | tee -a ~/.bashrc
echo "alias sdkmanager='sdkmanager.bat --sdk_root=\${ANDROID_HOME}/tools'" | tee -a ~/.bashrc

# ---
# REPO_OS_OVERRIDE : 'windows', 'macosx' ou 'linux' lorsque vous utilisez [sdkmanager] pour télécharger des packages pour un système d'exploitation différent de la machine actuelle.
# export REPO_OS_OVERRIDE="windows"

sdkmanager.bat --sdk_root=$(pwd)/peekathat/cmdline-tools/ --version
sdkmanager.bat --sdk_root=${ANDROID_HOME}/tools --version

alias sdkmanager='sdkmanager.bat --sdk_root=${ANDROID_HOME}/tools'
sdkmanager --version
sdkmanager --update

# ----
# The tutorial I read was using 'platforms;android-25' : 
#  + And i think 25 was the Android API level, not the Android SDK version, which is 14 in June 2023
#  + It is confirmed by https://github.com/taichi-dev/taichi/blob/51c709ca0a919602a3ebd2bb199be1059ffd8354/ci/Dockerfile.tpl#LL191C76-L191C86
export ANDROID_API_LEVEL_LATEST=33

export ANDROID_BUILD_TOOLS_LATEST=$(sdkmanager --list --newer | grep build-tools | grep ${ANDROID_API_LEVEL_LATEST} | tail -n 1 | awk '{print $3}')
export CMAKE_LATEST_VERSION=$(sdkmanager --list --newer | grep 'cmake' | tail -n 1 | awk '{print $3}')
export PLATFORM_TOOLS_LATEST_VERSION=$(sdkmanager --list --newer | grep 'platform-tools' | tail -n 1 | awk '{print $3}')
export PATCHER_LATEST_VERSION=$(sdkmanager --list --newer | grep 'patcher' | awk '{print $1}' | awk -F ';' '{print $NF}')

echo "  Available versions of Android SDK BUILD TOOLS : "
sdkmanager --list --newer | grep build-tools | grep ${ANDROID_API_LEVEL_LATEST}
echo "  Available versions of Android SDK ANDROID PLATFORM : "
sdkmanager --list --newer | grep 'platforms;android-' | grep ${ANDROID_API_LEVEL_LATEST}
echo "  Available versions of Android SDK 'cmake' : "
sdkmanager --list --newer | grep 'cmake'
echo "  Available versions of Android SDK PLATFORM TOOLS : "
sdkmanager --list --newer | grep 'platform-tools'
echo "  Available versions of Android SDK PATCHER : "
sdkmanager --list --newer | grep 'patcher'

echo "  LATEST version of Android SDK BUILD TOOLS : ANDROID_BUILD_TOOLS_LATEST=[${ANDROID_BUILD_TOOLS_LATEST}] "
echo "  LATEST version of Android SDK CMAKE : CMAKE_LATEST_VERSION=[${CMAKE_LATEST_VERSION}] "
echo "  LATEST version of Android SDK PLATFORM TOOLS : PLATFORM_TOOLS_LATEST_VERSION=[${PLATFORM_TOOLS_LATEST_VERSION}] "

sdkmanager --install \
    "ndk-bundle" \
    "build-tools;${ANDROID_BUILD_TOOLS_LATEST}" \
    "cmake;${CMAKE_LATEST_VERSION}" \
    "platforms;android-${ANDROID_API_LEVEL_LATEST}" \
    "platform-tools"

# --- -
#  We also could install  "patcher"
# - - -
#
# sdkmanager --install \
#     "ndk-bundle" \
#     "build-tools;${ANDROID_BUILD_TOOLS_LATEST}" \
#     "cmake;${CMAKE_LATEST_VERSION}" \
#     "platforms;android-${ANDROID_API_LEVEL_LATEST}" \
#     "platform-tools" \
#     "patcher;${PATCHER_LATEST_VERSION}" \















































































# ------------------------------------------------------------
# ------------------------------------------------------------
# ------------------------------------------------------------
# ------------------------------------------------------------
# ------------------------------------------------------------
# ------------------------------------------------------------
# ------------------------------------------------------------
# ------------------------------------------------------------
# ------------------------------------------------------------
# ------------------------------------------------------------
# ------------------------------------------------------------
# ------------------------------------------------------------
# ------------------------------------------------------------
# ------------------------------------------------------------
# ------------------------------------------------------------
# ------------------------------------------------------------
# ------------------------------------------------------------


exit 0
echo "BELOW JUST OTHER TRYOUTS: mainly, i note that some people in their CI do install simultaneously several versions of Platform Tools, Build Tools , and other Android SDK packages..."

export ANDROID_API_LEVEL=25
export ANDROID_API_LEVEL=33
export OTHER_ARGS_PKGS_I_THINK="platforms;android-${ANDROID_API_LEVEL} build-tools;25.0.2 extras;google;m2repository extras;android;m2repository"
export OTHER_ARGS_PKGS_I_THINK='platforms;android-25 build-tools;25.0.2 extras;google;m2repository extras;android;m2repository'
sdkmanager.bat ${OTHER_ARGS_PKGS_I_THINK} --sdk_root=$(pwd)/peekathat/cmdline-tools/


export ANDROID_API_LEVEL_LATEST=33
export ANDROID_API_LEVEL1="30"
export ANDROID_API_LEVEL2="33"

sdkmanager.bat --sdk_root=$(pwd)/peekathat/cmdline-tools/ \
    --install \
    "ndk-bundle" \
    "build-tools" \
    "cmake" \
    "platforms;android-${ANDROID_API_LEVEL_LATEST}" \
    "platform-tools" \
    "patcher;v4" \


export ANDROID_BUILD_TOOLS_MINOR_VERSION1="0"
export ANDROID_BUILD_TOOLS_PATCH_VERSION1="3"
export ANDROID_BUILD_TOOLS_MINOR_VERSION2="0"
export ANDROID_BUILD_TOOLS_PATCH_VERSION2="0"
export ANDROID_BUILD_TOOLS_VERSION1="${ANDROID_API_LEVEL1}.${ANDROID_BUILD_TOOLS_MINOR_VERSION1}.${ANDROID_BUILD_TOOLS_PATCH_VERSION1}"
export ANDROID_BUILD_TOOLS_VERSION2="${ANDROID_API_LEVEL2}.${ANDROID_BUILD_TOOLS_MINOR_VERSION2}.${ANDROID_BUILD_TOOLS_PATCH_VERSION2}"
export ANDROID_CMAKE_VERSION="3.10.2.4988404"


sdkmanager.bat --sdk_root=$(pwd)/peekathat/cmdline-tools/ \
    --install \
    "ndk-bundle" \
    "build-tools;${ANDROID_BUILD_TOOLS_VERSION1}" \
    "build-tools;${ANDROID_BUILD_TOOLS_VERSION2}" \
    "cmake;${ANDROID_CMAKE_VERSION}" \
    "platforms;android-${ANDROID_API_LEVEL1}" \
    "platforms;android-${ANDROID_API_LEVEL2}" \
    "platform-tools" \
    "patcher;v4" \

sdkmanager.bat --sdk_root=$(pwd)/peekathat/cmdline-tools/ \
    --install \
    "ndk-bundle" \
    "build-tools" \
    "cmake" \
    "platforms;android-${ANDROID_API_LEVEL_LATEST}" \
    "platform-tools" \
    "patcher;v4" \


    

# 
# -------------------------------------
# -->> The above commands will definitely install all other needed Android SDK packages : 
#        Tools > Android SDK Tools
#        Tools > Android SDK Platform-tools
#        Tools > Android SDK Build-tools
# -------------------------------------
# 

avdmanager.bat --help
lint.bat --version
profgen.bat --help
retrace.bat --help
screenshot2.bat --version || true


cd ../
