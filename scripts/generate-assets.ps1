Add-Type -AssemblyName System.Drawing

$assetsDir = Join-Path $PSScriptRoot "..\assets"
if (!(Test-Path $assetsDir)) {
    New-Item -ItemType Directory -Path $assetsDir -Force | Out-Null
}

$width = 1200
$height = 630
$bmp = [System.Drawing.Bitmap]::new($width, $height)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

# Background dark
$bgBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(14, 16, 20))
$g.FillRectangle($bgBrush, 0, 0, $width, $height)

# Gradient background accent
$rect = [System.Drawing.Rectangle]::new(0, 0, $width, $height)
$grad = [System.Drawing.Drawing2D.LinearGradientBrush]::new($rect, [System.Drawing.Color]::FromArgb(35, 88, 101, 242), [System.Drawing.Color]::FromArgb(10, 20, 25, 35), [float]35.0)
$g.FillRectangle($grad, 0, 0, $width, $height)

# Sleek card container
$cardRect = [System.Drawing.Rectangle]::new(70, 60, ($width - 140), ($height - 120))
$cardBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(220, 22, 25, 32))
$g.FillRectangle($cardBrush, $cardRect)

$cardBorder = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(60, 255, 255, 255), [float]2)
$g.DrawRectangle($cardBorder, $cardRect)

# Top accent bar on card
$barRect = [System.Drawing.Rectangle]::new(70, 60, ($width - 140), 6)
$barBrush = [System.Drawing.Drawing2D.LinearGradientBrush]::new($barRect, [System.Drawing.Color]::FromArgb(88, 101, 242), [System.Drawing.Color]::FromArgb(29, 185, 84), [float]0.0)
$g.FillRectangle($barBrush, $barRect)

# Fonts
$fontTitle = [System.Drawing.Font]::new("Segoe UI", [float]56, [System.Drawing.FontStyle]::Bold)
$fontDomain = [System.Drawing.Font]::new("Consolas", [float]22, [System.Drawing.FontStyle]::Bold)
$fontMeme = [System.Drawing.Font]::new("Segoe UI", [float]22, [System.Drawing.FontStyle]::Italic)
$fontDesc = [System.Drawing.Font]::new("Segoe UI", [float]19, [System.Drawing.FontStyle]::Regular)
$fontBadge = [System.Drawing.Font]::new("Segoe UI", [float]16, [System.Drawing.FontStyle]::Bold)

# Brushes
$white = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)
$muted = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(170, 175, 185))
$spotifyGreen = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(29, 185, 84))
$discordBlue = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(114, 137, 218))

# Logo polygon points on the right side
$scale = [float]2.3
$offsetX = [float]840
$offsetY = [float]130
$pts = [System.Drawing.PointF[]]@(
    [System.Drawing.PointF]::new($offsetX + 76.601 * $scale, $offsetY + 152.432 * $scale),
    [System.Drawing.PointF]::new($offsetX + 102.501 * $scale, $offsetY + 108.171 * $scale),
    [System.Drawing.PointF]::new($offsetX + 102.5 * $scale, $offsetY + 125.566 * $scale),
    [System.Drawing.PointF]::new($offsetX + 124.148 * $scale, $offsetY + 125.566 * $scale),
    [System.Drawing.PointF]::new($offsetX + 105.4 * $scale, $offsetY + 93.674 * $scale),
    [System.Drawing.PointF]::new($offsetX + 107.719 * $scale, $offsetY + 73.38 * $scale),
    [System.Drawing.PointF]::new($offsetX + 47.029 * $scale, $offsetY + 176.592 * $scale),
    [System.Drawing.PointF]::new($offsetX + 51.281 * $scale, $offsetY + 151.079 * $scale),
    [System.Drawing.PointF]::new($offsetX + 29.053 * $scale, $offsetY + 151.079 * $scale),
    [System.Drawing.PointF]::new($offsetX + 99.988 * $scale, $offsetY + 29.118 * $scale),
    [System.Drawing.PointF]::new($offsetX + 170.149 * $scale, $offsetY + 153.012 * $scale)
)
$path = [System.Drawing.Drawing2D.GraphicsPath]::new()
$path.AddPolygon($pts)
$logoBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(240, 255, 255, 255))
$g.FillPath($logoBrush, $path)

# Draw Title
$g.DrawString("AdoQeT", $fontTitle, $white, [float]130, [float]125)

# Domain pill badge
$pillRect = [System.Drawing.Rectangle]::new(130, 240, 310, 48)
$pillBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(35, 40, 52))
$g.FillRectangle($pillBrush, $pillRect)
$pillBorder = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(88, 101, 242), [float]2)
$g.DrawRectangle($pillBorder, $pillRect)

# Online dot
$dotBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(87, 242, 135))
$g.FillEllipse($dotBrush, 148, 256, 16, 16)
$g.DrawString("adoqet.is-a.dev", $fontDomain, $white, [float]176, [float]248)

# Racon / Meme quote
$g.DrawString('"sinan engin in instası sinanengin"', $fontMeme, $muted, [float]130, [float]315)
$g.DrawString("Kardeşler kalleş, kalleşler kardeş olmuş...", $fontDesc, $muted, [float]130, [float]365)

# Badges on bottom
$badgeRect1 = [System.Drawing.Rectangle]::new(130, 435, 220, 44)
$badgeRect2 = [System.Drawing.Rectangle]::new(370, 435, 250, 44)

$badgeBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(30, 33, 42))
$g.FillRectangle($badgeBrush, $badgeRect1)
$g.FillRectangle($badgeBrush, $badgeRect2)

$g.DrawString("Spotify Canli Player", $fontBadge, $spotifyGreen, [float]145, [float]445)
$g.DrawString("Discord Durum & Rozetler", $fontBadge, $discordBlue, [float]385, [float]445)

# Save og-banner.png
$bannerPath = Join-Path $assetsDir "og-banner.png"
$bmp.Save($bannerPath, [System.Drawing.Imaging.ImageFormat]::Png)

$g.Dispose()
$bmp.Dispose()

# Create favicon.png (128x128)
$favBmp = [System.Drawing.Bitmap]::new(128, 128)
$fg = [System.Drawing.Graphics]::FromImage($favBmp)
$fg.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$bgFav = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(16, 18, 20))
$fg.FillRectangle($bgFav, 0, 0, 128, 128)

$favScale = [float]0.55
$favOffX = [float]14
$favOffY = [float]14
$favPts = [System.Drawing.PointF[]]@(
    [System.Drawing.PointF]::new($favOffX + 76.601 * $favScale, $favOffY + 152.432 * $favScale),
    [System.Drawing.PointF]::new($favOffX + 102.501 * $favScale, $favOffY + 108.171 * $favScale),
    [System.Drawing.PointF]::new($favOffX + 102.5 * $favScale, $favOffY + 125.566 * $favScale),
    [System.Drawing.PointF]::new($favOffX + 124.148 * $favScale, $favOffY + 125.566 * $favScale),
    [System.Drawing.PointF]::new($favOffX + 105.4 * $favScale, $favOffY + 93.674 * $favScale),
    [System.Drawing.PointF]::new($favOffX + 107.719 * $favScale, $favOffY + 73.38 * $favScale),
    [System.Drawing.PointF]::new($favOffX + 47.029 * $favScale, $favOffY + 176.592 * $favScale),
    [System.Drawing.PointF]::new($favOffX + 51.281 * $favScale, $favOffY + 151.079 * $favScale),
    [System.Drawing.PointF]::new($favOffX + 29.053 * $favScale, $favOffY + 151.079 * $favScale),
    [System.Drawing.PointF]::new($favOffX + 99.988 * $favScale, $favOffY + 29.118 * $favScale),
    [System.Drawing.PointF]::new($favOffX + 170.149 * $favScale, $favOffY + 153.012 * $favScale)
)
$favPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
$favPath.AddPolygon($favPts)
$fg.FillPath($white, $favPath)

$favOut = Join-Path $assetsDir "favicon.png"
$appleOut = Join-Path $assetsDir "apple-touch-icon.png"
$favBmp.Save($favOut, [System.Drawing.Imaging.ImageFormat]::Png)
$favBmp.Save($appleOut, [System.Drawing.Imaging.ImageFormat]::Png)

$fg.Dispose()
$favBmp.Dispose()

Write-Output "Assets successfully generated in $assetsDir"
