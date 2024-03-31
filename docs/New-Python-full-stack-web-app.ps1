<#
.SYNOPSIS
    This is an automation Script to create a full stack python web app Project
.DESCRIPTION
    By far the easiest way to set up a new React project is to use the official Create React App script: https://facebook.github.io/create-react-app/
    This script can do the same thing but it allows to set up your app with your custom tweaks, and helps you understand how the underlying tech works.
.NOTES
    Information or caveats about the function e.g. 'This function is not supported in Linux'
.LINK
    Specify a URI to a help page, this will show when Get-Help -Online is used.
.EXAMPLE
    Test-MyTestFunction -Verbose
    Explanation of the function or its result. You can include multiple examples with additional .EXAMPLE lines
#>
class InvalidInput : System.SystemException {
    [string]$Message
    InvalidInput() { $this.Message = "Invalid Input." }
    InvalidInput([string]$msg) { $this.Message = $msg }
}

function Test-ValidProjectName ([string]$string) {
    if ([string]::IsNullOrWhiteSpace($string)) {
        throw [InvalidInput]::new('Empty names are not allowed. Please Input a valid folder Name.')
    } else {
        # https://codeburst.io/creating-a-full-stack-web-application-with-python-npm-webpack-and-react-8925800503d9
        #     bool IsValidFilename(string testName)
        # {
        #     Regex containsABadCharacter = new Regex("[" + Regex.Escape(System.IO.Path.InvalidPathChars) + "]");
        #     if (containsABadCharacter.IsMatch(testName) { return false; };

        #     // other checks for UNC, drive-path format, etc

        #     return true;
        # }
        [string[]]$arr = $string.ToCharArray()
        [IO.Path]::InvalidPathChars | ForEach-Object {
            if ($arr -contains "$_") {
                throw [InvalidInput]::new("Folder name containing $_ is not valid.")
            }
        }
    }
}
function Initialize-Project {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, ValueFromPipeline)]
        [ValidateScript({ Test-ValidProjectName $_ }, ErrorMessage = "Invalid Name.")]
        [Alias('ProjectName', 'n')]
        [string]$Name
    )

    begin {

    }

    process {

    }

    end {

    }
}
$PROJECT_NAME = Read-Host -Prompt "Project Name" -ErrorAction Stop
Write-Host "Initial Project Setup ...`n"
Write-Host @"
.
├── README.md
└── fullstack_template/
    ├── server/
    └── static/
        ├── css/
        ├── dist/
        ├── images/
        └── js/
"@

Write-Host "`nCreated Directory tree. in $PROJECT_NAME`n"

Write-Host "Using the npm package manager ..."
