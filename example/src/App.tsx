import * as React from "react";
import { Button, StyleSheet, View } from "react-native";
import * as FileSystem from "expo-file-system";
import * as DocumentOpener from "react-native-document-opener";

export default function App() {
  const downloadFile = () => {
    return FileSystem.downloadAsync(
      "http://techslides.com/demos/sample-videos/small.mp4",
      FileSystem.documentDirectory + "small-video.mp4"
    );
  };

  const handleOnOpenPress = async () => {
    try {
      const result = await downloadFile();
      await DocumentOpener.openAsync(result.uri, result.mimeType ?? undefined);
    } catch (error) {
      console.error(error);
    }
  };

  const handleOnOptionsPress = async () => {
    try {
      const result = await downloadFile();
      await DocumentOpener.presentOptionsAsync(result.uri);
    } catch (error) {
      console.error(error);
    }
  };

  return (
    <View style={styles.container}>
      <Button onPress={handleOnOpenPress} title="Download & open file" />
      <View style={styles.spacer} />
      <Button onPress={handleOnOptionsPress} title="Download & show file options (iOS only)" />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: "center",
    justifyContent: "center",
  },
  spacer: {
    height: 20,
  },
});
