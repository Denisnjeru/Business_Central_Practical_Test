FROM mcr.microsoft.com/businesscentral/sandbox:latest

COPY BC.bclicense c:/run/BC.bclicense

COPY Helan_Dala-Dala_1.0.0.0.app c:/run/Helan_Dala-Dala_1.0.0.0.app

# RUN powershell -NoProfile -Command `
#     if (Test-Path -Path "c:\run\BC.bclicense") { `
#         Import-NAVServerLicense -LicenseFile "c:\run\BC.bclicense" -ServerInstance BC; `
#     }; `
#     Publish-NAVApp -ServerInstance BC -Path "c:\run\Helan_Dala-Dala_1.0.0.0.app" -SkipVerification; `
#     -PackageType Extension -Force; `
#     Install-NAVApp -ServerInstance BC -Name "Helan_Dala-Dala_1.0.0.0" -Force