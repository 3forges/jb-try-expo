import { ExpoConfig } from 'expo/config';

// In SDK 46 and lower, use the following import instead:
// import { ExpoConfig } from '@expo/config-types';

const config: ExpoConfig = {
  name: 'pesto',
  slug: 'Pesto',
  android: {
    package: "io.troisforges.pesto"
  }
};

export default config;
