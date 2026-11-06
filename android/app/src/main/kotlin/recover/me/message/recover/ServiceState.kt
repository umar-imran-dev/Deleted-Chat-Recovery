package recover.me.message.recover

// Service abhi system se jurri hui hai ya nahi
object ServiceState {
    @Volatile
    var connected: Boolean = false
}