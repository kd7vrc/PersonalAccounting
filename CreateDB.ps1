#!/usr/bin/env pwsh
param([string]$dbname="TemplateDB")
sqlite3 ".\UserData\"$dbname".db"
.quit