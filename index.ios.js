/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';
import React, {
  AppRegistry,
  Component,
  StyleSheet,
  Text,
  View,
  TouchableHighlight,
  NativeModules,
} from 'react-native'

const { SpeechToTextManager } = NativeModules

class Seona extends Component {
  constructor(props) {
    super(props)

    this._onPress         = this._onPress.bind(this)
    this._onTranscribing  = this._onTranscribing.bind(this)

    this.state = { currentState: 'WAITING', result: null, }
  }

  _onPress() {
    switch (this.state.currentState) {
      case 'WAITING':
        this.setState({ currentState: 'RECORDING', result: null, })
        SpeechToTextManager.startRecording(result => console.log('RECORD SUCCESS ' + result))
        break
      case 'RECORDING':
        this.setState({ currentState: 'TRANSCRIBING' })
        SpeechToTextManager.stopRecording()
        SpeechToTextManager.startService('API_USERNAME', 'API_PASSWORD')
        SpeechToTextManager.transcript(this._onTranscribing)
        break
    }
  }

  _onTranscribing(result) {
    this.setState({ currentState: 'WAITING', result })
  }

  render() {
    return (
      <View style={styles.body}>
        <View style={styles.container}>
          <Text style={styles.result}>
            {this.state.result}
          </Text>
        </View>
        <TouchableHighlight
          style={[styles.button, stateStyles[this.state.currentState]]}
          onPress={this._onPress}
          underlayColor="#00405d"
        >
          <Text style={styles.buttonLabel}>
            {stateButtonLabels[this.state.currentState]}
          </Text>
        </TouchableHighlight>
      </View>
    )
  }
}

const styles = StyleSheet.create({
  body: {
    flex: 1,
  },
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  result: {
    textAlign: 'center',
  },
  button: {
    padding: 15,
  },
  buttonLabel: {
    fontSize: 20,
    fontWeight: 'normal',
    textAlign: 'center',
    color: '#fff',
  },
  waitingStateButton: {
    backgroundColor: '#0099e5',
  },
  recordingStateButton: {
    backgroundColor: '#fd5c63',
  },
  transcribingStateButton: {
    backgroundColor: '#8ec06c',
  },
})

const stateStyles = StyleSheet.create({
  WAITING: { backgroundColor: '#0099e5' },
  RECORDING: { backgroundColor: '#fd5c63' },
  TRANSCRIBING: { backgroundColor: '#8ec06c' },
})

const stateButtonLabels = {
  WAITING: 'Touch to record',
  RECORDING: 'Recording...',
  TRANSCRIBING: 'Transcribing in progress...',
}

AppRegistry.registerComponent('Seona', () => Seona)
