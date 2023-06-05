// import { getDefaultConfig } from 'expo/metro-config';
const metroConfig = require('expo/metro-config');
const config = metroConfig.getDefaultConfig(__dirname);
module.exports = config;
