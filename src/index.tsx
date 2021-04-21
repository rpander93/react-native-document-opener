import { NativeModules } from 'react-native';

type DocumentOpenerType = {
  multiply(a: number, b: number): Promise<number>;
};

const { DocumentOpener } = NativeModules;

export default DocumentOpener as DocumentOpenerType;
