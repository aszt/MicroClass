// Place your Spring DSL code here
beans = {
    jmsConnectionFactory(org.apache.activemq.ActiveMQConnectionFactory ) {
        brokerURL = "tcp://localhost:61616"
        userName = "admin"
        password = "admin"
    }
}
