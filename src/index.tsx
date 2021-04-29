import { NativeModules, Platform } from 'react-native';

function cleanPath(filePath: string) {
  return filePath.replace('file://', '');
}

export function openAsync(filePath: string, mimeType?: string): Promise<void> {
  return NativeModules.DocumentOpener.openAsync(cleanPath(filePath), mimeType);
}

export function presentOptionsAsync(filePath: string, mimeType?: string): Promise<void> {
  if (Platform.OS === 'android') throw new Error('presentOptionsAsync is not supported on Android');
  return NativeModules.DocumentOpener.presentOptionsAsync(cleanPath(filePath), mimeType);
}
