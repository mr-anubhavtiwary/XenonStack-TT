#!/bin/bash

VERSION="v0.1.0"

display_help() {
    echo "Usage: sysopctl [option] [command]"
    echo
    echo "Commands:"
    echo "  --help                Display this help message."
    echo "  --version             Display the version of sysopctl."
    echo "  service list          List all running services."
    echo "  service start <name>  Start a specified service."
    echo "  service stop <name>   Stop a specified service."
    echo "  system load           View system load averages."
    echo "  disk usage            Check disk usage."
    echo "  process monitor       Monitor system processes in real-time."
    echo "  logs analyze          Analyze system logs."
    echo "  backup <path>         Backup files from a specified path."
    echo
}

display_version() {
    echo "sysopctl version $VERSION"
}

manage_service() {
    case "$1" in
        list)
            systemctl list-units --type=service
            ;;
        start)
            systemctl start "$2"
            echo "Service $2 started."
            ;;
        stop)
            systemctl stop "$2"
            echo "Service $2 stopped."
            ;;
        *)
            echo "Invalid service command. Use --help for options."
            ;;
    esac
}

view_system_load() {
    uptime
}

check_disk_usage() {
    df -h
}

monitor_processes() {
    top
}

analyze_logs() {
  echo "Summary of recent critical log entries"
    journalctl -p crit -n 10 --no-pager
}

backup_files() {
    rsync -av --progress "$1" 
/
    echo "Backup from $1 completed."
}

# Main commands
case "$1" in
    --help)
        display_help
        ;;
    --version)
        display_version
        ;;
    service)
        manage_service "$2" "$3"
        ;;
    system)
        if [ "$2" == "load" ]; then
            view_system_load
        fi
        ;;
    disk)
        if [ "$2" == "usage" ]; then
            check_disk_usage
        fi
        ;;
    process)
        if [ "$2" == "monitor" ]; then
            monitor_processes
        fi
        ;;
    logs)
        if [ "$2" == "analyze" ]; then
            analyze_logs
        fi
        ;;
    backup)
        if [ -n "$2" ]; then
            backup_files "$2"
        else
            echo "Please provide a path to backup."
        fi
        ;;
    *)
        echo "Invalid option. Use --help for usage information."
        ;;
esac
