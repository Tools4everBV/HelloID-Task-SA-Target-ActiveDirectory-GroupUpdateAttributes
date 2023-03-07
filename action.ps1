# HelloID-Task-SA-Target-ActiveDirectory-GroupUpdateAttributes
##############################################################

# Form mapping
$formObject = @{
    Identity    = $form.Name
    DisplayName = $form.DisplayName
    Description = $form.Description
}

try {
    Write-Information "Executing ActiveDirectory action: [GroupUpdateAttributes] for: [$($formObject.DisplayName)]"
    Import-Module ActiveDirectory -ErrorAction Stop
    $group = Get-ADgroup -Identity $formObject.Identity
    if ($null -eq $group) {
        Write-Error  "ActiveDirectory group [$($formObject.DisplayName)] does not exist"
    } else {
        $null = Set-ADGroup @formObject
        $auditLog = @{
            Action            = 'UpdateResource'
            System            = 'ActiveDirectory'
            TargetIdentifier  = $([string]$group.SID)
            TargetDisplayName = $formObject.DisplayName
            Message           = "ActiveDirectory action: [GroupUpdateAttributes] for: [$($formObject.DisplayName)] executed successfully"
            IsError           = $false
        }
        Write-Information -Tags 'Audit' -MessageData $auditLog
        Write-Information "ActiveDirectory action: [GroupUpdateAttributes] for: [$($formObject.DisplayName)] executed successfully"
    }
} catch {
    $ex = $_
    $auditLog = @{
        Action            = 'UpdateResource'
        System            = 'ActiveDirectory'
        TargetIdentifier  = $([string]$group.SID)
        TargetDisplayName = $formObject.DisplayName
        Message           = "Could not execute ActiveDirectory action: [GroupUpdateAttributes] for: [$($formObject.DisplayName)], error: $($ex.Exception.Message)"
        IsError           = $true
    }
    Write-Information -Tags 'Audit' -MessageData $auditLog
    Write-Error "Could not execute ActiveDirectory action: [GroupUpdateAttributes] for: [$($formObject.DisplayName)], error: $($ex.Exception.Message)"
}
##############################################################
