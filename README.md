# react-native-cs-token-grabber

## Getting started

`$ yarn add react-native-cs-token-grabber`

### Pod installation

`$ cd ios && pod install && cd ..`

## Usage

```javascript
import CsTokenGrabber from 'react-native-cs-token-grabber';

// Get token
const nativeToken = await CsTokenGrabber.authToken();
// Delete token
await CsTokenGrabber.deleteAuthToken();
```
