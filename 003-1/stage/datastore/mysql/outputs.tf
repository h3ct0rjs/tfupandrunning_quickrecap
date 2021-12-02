output "dbaddress" {      
    value = aws_db_instance.database.address
    description = "Connect to Rds Instance at address >"
}

output "dbport" {
    value = aws_db_instance.database.port
    description = "Connect to Rds Port >"
}