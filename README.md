# 📖 react-native-document-opener

This is a React Native library that opens documents using their native components on Android (via a [File Provider](https://developer.android.com/reference/androidx/core/content/FileProvider)) and iOS (via a [UIDocumentInteractionController](https://developer.apple.com/documentation/uikit/uidocumentinteractioncontroller)).

## Installation

Use yarn to install the library from npm.

```bash
yarn add react-native-document-opener
```

## Usage

The library exposes two methods that allow you to open documents:

```typescript
import * as DocumentOpener from 'react-native-document-opener';

// Immediately opens document. Mime type is optional and ignored on iOS
DocumentOpener.openAsync('path/to/local/file.mp4', 'video/mp4');

// Opens options menu (iOS only)
DocumentOpener.presentOptionsAsync('path/to/local/file.mp4');
```

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License
[MIT](LICENSE)
