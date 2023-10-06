
# HelloID-Task-SA-Target-ActiveDirectory-GroupUpdateAttributes

## Prerequisites

- [ ] The HelloID SA on-premises agent installed

- [ ] The ActiveDirectory module is installed on the server where the HelloID SA on-premises agent is running.

## Description

This code snippet executes the following tasks:

1. Define a hash table `$formObject`. The keys of the hash table represent the properties of the `Set-ADGroup` cmdlet, while the values represent the values entered in the form.

> To view an example of the form output, please refer to the JSON code pasted below.

```json
{
    "GroupIdentity": "TestGroup",  // Required to lookup the ADgroup to Update, This property will not be updated.
    "GroupDisplayName": "TestGroupNew",
    "GroupDescription": "TestGroupNew"
}
```

> :exclamation: It is important to note that the names of your form fields might differ. Ensure that the `$formObject` hashtable is appropriately adjusted to match your form fields.
> The field **GroupIdentity** accepts different values [See the Microsoft Docs page](https://learn.microsoft.com/en-us/powershell/module/activedirectory/set-adgroup?view=windowsserver2022-ps)

2. Imports the ActiveDirectory module.

3. Retrieve the group object using the `Get-ADGroup` cmdlet using the `Identity` property.

4. Update the group using the `$group` object retrieved from step 3. The hash table called `$formObject` is passed to the `Set-ADGroup` cmdlet using the `@` symbol in front of the hash table name.