# Expo very fisrst try



```bash

npx create-expo-app my-app
```


## The first tutorial

* https://docs.expo.dev/tutorial/introduction/

#### Install `pnpm`

* There : 

```bash

```


#### Scaffold the project's code

```bash
# Pesto instead of StickerSmash
# npx create-expo-app Pesto
# pnpm dlx create-expo-app Pesto # that a non typescript javascript project
pnpm dlx create-expo-app -t expo-template-blank-typescript Pesto

cd ./Pesto/

# npx expo install react-dom react-native-web @expo/webpack-config
pnpm i && pnpm dlx expo install react-dom react-native-web @expo/webpack-config


# npx expo start
pnpm dlx expo start

```

#### Adding first screen to the app

We will add a new screen using the **`expo`** [Core Components](https://reactnative.dev/docs/components-and-apis)



```bash

cat <<EOF >./App.js
import { StatusBar } from 'expo-status-bar';
import { StyleSheet, Text, View } from 'react-native';

export default function App() {
  return (
    <View style={styles.container}>
      <Text>Open up App.js to start working on your app!</Text>
      <StatusBar style="auto" />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#25292e',
    alignItems: 'center',
    justifyContent: 'center',
  },
});

EOF

```

#### Using Typescript in expo

* source : https://docs.expo.dev/guides/typescript/



```bash
# Pesto instead of StickerSmash
# npx create-expo-app Pesto
# pnpm dlx create-expo-app Pesto # that a non typescript javascript project
pnpm dlx create-expo-app -t expo-template-blank-typescript Pesto

cd ./Pesto/

# npx expo install react-dom react-native-web @expo/webpack-config
pnpm i && pnpm dlx expo install react-dom react-native-web @expo/webpack-config @expo/metro-config

# yarn add -D ts-node typescript
pnpm add -D ts-node typescript @types/expo




cat <<EOF >./webpack.config.js
require('ts-node/register');
module.exports = require('./webpack.config.ts');

EOF


cat <<EOF >./webpack.config.ts
import createExpoWebpackConfigAsync from '@expo/webpack-config/webpack';
import { Arguments, Environment } from '@expo/webpack-config/webpack/types';

module.exports = async function (env: Environment, argv: Arguments) {
  const config = await createExpoWebpackConfigAsync(env, argv);
  // Customize the config before returning it.
  return config;
};

EOF




cat <<EOF >./metro.config.js
require('ts-node/register');
module.exports = require('./metro.config.ts');
EOF


# ---
# I had to fix the [./metro.config.ts] configuration file : [import { getDefaultConfig } from 'expo/metro-config';]  kept throwing an error : 
# --- 
#  TSError: ⨯ Unable to compile TypeScript:
#  metro.config.ts(1,34): error TS7016: Could not find a declaration file #  for module 'expo/metro-config'. 
# --- 
# 
# cat <<EOF >./metro.config.ts
# import { getDefaultConfig } from 'expo/metro-config';
# const config = getDefaultConfig(__dirname);
# module.exports = config;
# EOF

cat <<EOF >./metro.config.ts
// import { getDefaultConfig } from 'expo/metro-config';
const metroConfig = require('expo/metro-config');
const config = metroConfig.getDefaultConfig(__dirname);
module.exports = config;
EOF




cat <<EOF >./app.config.js
require('ts-node/register');
module.exports = require('./app.config.ts');
EOF


cat <<EOF >./app.config.ts
import { ExpoConfig } from 'expo/config';

// In SDK 46 and lower, use the following import instead:
// import { ExpoConfig } from '@expo/config-types';

const config: ExpoConfig = {
  name: 'my-app',
  slug: 'my-app',
};

export default config;
EOF

pnpm add -D metro metro-core @types/metro

# ---
# Install Android SDK 





# npx expo start
pnpm dlx expo start

# pnpm dlx expo run:android
pnpm dlx expo . -p android
```

# ANNEX: Android API Levels

For each Android SDK Release ersion number, there is at least one, potentially several Android API Levels.

For each Android API Level, there always is one and only,one Android SDK version.


So Android API levels and sort of subversions of Android SDK releaseversion.

match between Android SDK versions and Android API Levels: https://developer.android.com/tools/releases/platforms#13


# ANNEX: The Issues whos who


### First error : metro bundler error calling android

Releated issue 
* He has exactly same err msg than me : https://github.com/expo/expo-cli/issues/1839
* I learned that on windows, setting up WSL is mandatory to be able to run the android : https://docs.expo.dev/archive/classic-updates/building-standalone-apps/?redirected#1-install-expo-cli 

So this error should disappear as soon as I : 
* Enable and setup WSL as instructed by the expo documentation
* something else ?


I then: 
* modified the `app.json` and the `app.config.ts` so they define `android.package`, set to `io.troisforges.pesto`
* then i ran again the `pnpm dlx expo build:android`, and I got this new error (I did not set up the `WSL` yet) : 

```bash
.../Local/pnpm/store/v3/tmp/dlx-7792     | Progress: resolved 644, reused 590, downloaded 0, added 544
.../Local/pnpm/store/v3/tmp/dlx-7792     | Progress: resolved 644, reused 590, downloaded 0, added 590, done

  $ expo build:android is not supported in the local CLI, please use eas build -p android instead

 ERROR  Command failed with exit code 1: C:\Users\Utilisateur\AppData\Local\pnpm\store\v3\tmp\dlx-7792\node_modules\.bin\expo.CMD build:android

pnpm: Command failed with exit code 1: C:\Users\Utilisateur\AppData\Local\pnpm\store\v3\tmp\dlx-7792\node_modules\.bin\expo.CMD build:android
    at makeError (C:\Users\Utilisateur\AppData\Roaming\npm\node_modules\pnpm\dist\pnpm.cjs:22159:17)
    at handlePromise (C:\Users\Utilisateur\AppData\Roaming\npm\node_modules\pnpm\dist\pnpm.cjs:22730:33)
    at process.processTicksAndRejections (node:internal/process/task_queues:95:5)
    at async Object.handler [as dlx] (C:\Users\Utilisateur\AppData\Roaming\npm\node_modules\pnpm\dist\pnpm.cjs:184008:7)
    at async C:\Users\Utilisateur\AppData\Roaming\npm\node_modules\pnpm\dist\pnpm.cjs:192497:21
    at async run (C:\Users\Utilisateur\AppData\Roaming\npm\node_modules\pnpm\dist\pnpm.cjs:192471:34)
    at async runPnpm (C:\Users\Utilisateur\AppData\Roaming\npm\node_modules\pnpm\dist\pnpm.cjs:192689:5)
    at async C:\Users\Utilisateur\AppData\Roaming\npm\node_modules\pnpm\dist\pnpm.cjs:192681:7


```
* I then 
```bash
pnpm dlx expo . -p android
```
What I read : 
* https://eoluwakayode34.medium.com/expo-cli-is-in-non-interactive-mode-getting-started-with-expo-cli-lets-fix-it-ace5f6e72fee

Obviously, I here solved al issues, excet this TTY issue, specific to the expo CLI, and I have 3 things left to try : 
* to re-check the expo CLI installation full process
* to install and setup WSL on my windows
* to automate the sale full process for the expo project, but on debian 11 instead of Windows 


# ANNEX: References

* Quickstart install (not really a tutorial, just one command) : https://docs.expo.dev/
* First tutorial : https://docs.expo.dev/tutorial/introduction/
* About how to code in typescript with expo : https://docs.expo.dev/guides/typescript/
* match between Android SDK versions and Android API Levels: https://developer.android.com/tools/releases/platforms#13
* Fruitful gthub search : 
  * https://github.com/search?q=platforms%3Bandroid-33&type=code

* **_VERY INTERESTING EXAMPLE OF CI PIPELINE FOR MOBILE APP WITH ANDROID SDK_** : https://github.com/taichi-dev/taichi/blob/51c709ca0a919602a3ebd2bb199be1059ffd8354/ci/Dockerfile.tpl#LL191C76-L191C86

* Interesting issues i fell on: 
  * https://github.com/expo/eas-cli/issues/1470


* Interesting :
  * https://eoluwakayode34.medium.com/expo-cli-is-in-non-interactive-mode-getting-started-with-expo-cli-lets-fix-it-ace5f6e72fee