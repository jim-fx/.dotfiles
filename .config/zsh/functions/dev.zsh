function dev() {
  PROJECT_DIR="$HOME/Projects/dev/services"

  case "$1" in
    start)
      shift
      docker compose -f "$PROJECT_DIR/docker-compose.yml" --profile $@ up -d
      ;;
    restart)
      shift
      docker compose -f "$PROJECT_DIR/docker-compose.yml" --profile "$@" restart
      ;;
    stop)
      shift
      docker compose -f "$PROJECT_DIR/docker-compose.yml" --profile "$@" down --remove-orphans
      ;;
    logs)
      shift
      docker compose -f "$PROJECT_DIR/docker-compose.yml" --profile "$@" logs -f
      ;;
    *)
      echo "Usage: dev {start|restart|stop|logs} [services...]"
      ;;
  esac
}

