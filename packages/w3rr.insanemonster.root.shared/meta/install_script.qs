/****************************************************************************
**
** Copyright (C) 2017 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the FOO module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:GPL-EXCEPT$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3 as published by the Free Software
** Foundation with exceptions as appearing in the file LICENSE.GPL3-EXCEPT
** included in the packaging of this file. Please review the following
** information to ensure the GNU General Public License requirements will
** be met: https://www.gnu.org/licenses/gpl-3.0.html.
**
** $QT_END_LICENSE$
**
****************************************************************************/

function Component()
{
    // Constructor
    // Connect to installer loaded function
    component.loaded.connect(this, Component.prototype.pageLoaded);
}

Component.prototype.pageLoaded = function()
{
    // Add campaigns page after installation finished -> just for shared component (always installed)
    if(installer.addWizardPage(component, "CampaignsPage", QInstaller.InstallationFinished))
    {
        // If page addition is successful connect to custom buttons
        var page = gui.pageWidgetByObjectName("DynamicCampaignsPage");
        if (page != null)
        {
            page.patreonPushButton.clicked.connect(this, Component.prototype.openPatreonUrl);
            page.paypalPushButton.clicked.connect(this, Component.prototype.openPaypalUrl);
        }
    }
}

Component.prototype.openPatreonUrl = function()
{
    // Open Patreon URL
    QDesktopServices.openUrl("https://www.patreon.com/insanemonster");
}

Component.prototype.openPaypalUrl = function()
{
    // Open PayPal URL
    QDesktopServices.openUrl("https://www.paypal.com/donate/?hosted_button_id=9SNWTXNW4NGGA");
}

Component.prototype.createOperationsForArchive = function(archive)
{
    // Extract data to _retail_
    component.addOperation("Extract", archive, "@TargetDir@/_retail_");
}
