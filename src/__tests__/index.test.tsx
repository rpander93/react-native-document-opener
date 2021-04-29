import { NativeModules, Platform } from 'react-native';
import * as DocumentOpener from '../index';

jest.mock('react-native', () => ({
  NativeModules: {
    DocumentOpener: {
      openAsync: jest.fn(() => Promise.resolve()),
      presentOptionsAsync: jest.fn(() => Promise.resolve()),
    },
  },
  Platform: {
    OS: 'ios',
  },
}));

describe('DocumentOpener', () => {
  it('opens a document using the native module', () => {
    const filePath = 'file:///data/0/emulated/com.example.reactnativedocumentopener/files/example.mp4';
    const mimeType = 'video/mp4';

    DocumentOpener.openAsync(filePath, mimeType);

    const spy = jest.spyOn(NativeModules.DocumentOpener, 'openAsync');
    expect(spy).toHaveBeenCalledWith(filePath.substr(7), mimeType);
  });

  it('opens document options using the native module', () => {
    const filePath = 'file:///data/0/emulated/com.example.reactnativedocumentopener/files/example.mp4';
    DocumentOpener.presentOptionsAsync(filePath);

    const spy = jest.spyOn(NativeModules.DocumentOpener, 'presentOptionsAsync');
    expect(spy).toHaveBeenCalledWith(filePath.substr(7));
  });

  it('throws error when trying to present document options on Android', () => {
    const t = () => {
      Platform.OS = 'android';
      DocumentOpener.presentOptionsAsync('file://does-not-exist.mp4');
    };

    expect(t).toThrowError();
  });
});
