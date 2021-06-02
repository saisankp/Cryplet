# <h1 align="center">Cryplet</h1>
<h2 align="center">A cryptocurrency wallet developed with Flutter using Firestore and Firebase Authentication.</h2>
<img src="demo/cryplet-demo.gif" width="500" height="500" align="right"/>
<h3 align="center">Why did you make this?</h3>
<p>As someone who had not used Flutter before, I was eager to start developing my first Flutter application and decided to learn how to use Firestore and Firebase Authentication. Since I had an interest in cryptocurrencies, I made this application which let's users log in or register with a password, and let's them add a handful of different crypto coins into their own dedicated crypto wallet. <br><br>
While developing this simple application, I learned how to write code using Flutter, which I thoroughly enjoyed. I also learned about Firestore databases and setting them up. Finally, I understood how to use Firebase Authentication to authenticate the username and password of various users. Situations such as using a weak password to register or attempting the wrong password will show an error box depending on the operating system of the user. For example on IOS devices the user would see a Cupertino Dialog box for the error, and a different dialog box on other operating systems such as Android.</p>
<p>This application also makes API calls to the <a href="https://www.coingecko.com/en/api#explore-api">CoinGecko cryptocurrency API</a> to show the user the current updated price of their particular crypto coins. The user can refresh the page by pressing the refresh button to update the prices being shown. The user can also add coins to their wallet with the press of a button, which will all be stored in the Firestore database.</p>

<h2 align="center">Some resources which helped me.</h2>

Here are a few links which helped me make my first Flutter application.
- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)
- [Official Online Documentation](https://flutter.dev/docs)
