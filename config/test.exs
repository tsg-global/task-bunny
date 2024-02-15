import Config

config :logger, backends: [{LoggerFileBackend, :log_file}]
config :logger, :log_file, level: :debug, path: "logs/test.log"

config :task_bunny,
  disable_auto_start: false,
  hosts: [
    default: [
      connect_options: "amqp://rabbitmq:rabbitmq@localhost:5672?heartbeat=30"
    ]
  ]
