# HelloID-Task-SA-Target-ActiveDirectory-GroupUpdateAttributes
##############################################################

# Form mapping
$formObject = @{
    GroupIdentity    = $form.GroupIdentity
    GroupDisplayName = $form.GroupDisplayName
    GroupDescription = $form.GroupDescription
}

try {
    Write-Information "Executing ActiveDirectory action: [GroupUpdateAttributes] for: [$($formObject.GroupDisplayName)]"
    Import-Module ActiveDirectory -ErrorAction Stop
    $group = Get-ADgroup -Identity $formObject.GroupIdentity
    if ($null -eq $group) {
        Write-Error  "ActiveDirectory group [$($formObject.GroupDisplayName)] does not exist"
    } else {
        $null = Set-ADGroup @formObject
        $auditLog = @{
            Action            = 'UpdateResource'
            System            = 'ActiveDirectory'
            TargetIdentifier  = $([string]$group.SID)
            TargetDisplayName = $formObject.GroupDisplayName
            Message           = "ActiveDirectory action: [GroupUpdateAttributes] for: [$($formObject.GroupDisplayName)] executed successfully"
            IsError           = $false
        }
        Write-Information -Tags 'Audit' -MessageData $auditLog
        Write-Information "ActiveDirectory action: [GroupUpdateAttributes] for: [$($formObject.GroupDisplayName)] executed successfully"
    }
} catch {
    $ex = $_
    $auditLog = @{
        Action            = 'UpdateResource'
        System            = 'ActiveDirectory'
        TargetIdentifier  = $([string]$group.SID)
        TargetDisplayName = $formObject.GroupDisplayName
        Message           = "Could not execute ActiveDirectory action: [GroupUpdateAttributes] for: [$($formObject.GroupDisplayName)], error: $($ex.Exception.Message)"
        IsError           = $true
    }
    Write-Information -Tags 'Audit' -MessageData $auditLog
    Write-Error "Could not execute ActiveDirectory action: [GroupUpdateAttributes] for: [$($formObject.GroupDisplayName)], error: $($ex.Exception.Message)"
}
##############################################################
