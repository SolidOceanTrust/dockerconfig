Start-PodeServer {

    Add-PodeEndpoint -Address localhost -Port 8080 -Protocol Http

    Add-PodeRoute -Method Get -Path '/' -ScriptBlock {
        # Import SiteList into Memory
        try {
            $siteListObject = Import-LocalizedData -FileName sitelist.psd1 -ErrorAction Stop
        }
        catch {
            $siteListObject = 'Failed to Load SiteList.psd1 :('
        }
        Write-PodeHTMLResponse -Value $($siteListObject.GetEnumerator())
    }

    Add-PodeRoute -Method Get -Path '/go/:site' -ScriptBlock {
        $siteName = $WebEvent.Parameters['site'] 

        # Import SiteList into Memory
        try {
            $siteListObject = Import-LocalizedData -FileName sitelist.psd1 -ErrorAction Stop
        }
        catch {
            $siteListObject = 'Failed to Load SiteList.psd1 :('
        }

        # Find the Site
        $url = $siteListObject[$siteName]
        if ($url -eq $null) {
            Write-PodeTextResponse -Value "Real URL Not Found for ($siteName) :("
        }
        else {
            Write-PodeTextResponse -Value $url
            Move-PodeResponseUrl -Url $url -Moved
        }
    }
}