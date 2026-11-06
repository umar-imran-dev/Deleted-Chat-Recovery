# Flutter ke deferred components Play Core ka zikr karte hain jo is app mein nahi hai.
# Iske baghair R8 "Missing class com.google.android.play.core..." par build rok deta hai.
-dontwarn com.google.android.play.core.**

# Manifest mein likhi service aur activity ko R8 hataye na (HeadlessEngine / listener)
-keep class recover.me.message.recover.MessagesListenerService { *; }
-keep class recover.me.message.recover.MainActivity { *; }