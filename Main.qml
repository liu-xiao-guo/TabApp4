import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.ListItems 1.0 as ListItem

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "tabapp.ubuntu"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    //automaticOrientation: true

    // Removes the old toolbar and enables new features of the new header.
    useDeprecatedToolbar: false

    width: units.gu(50)
    height: units.gu(75)

    Action {
        id: reloadAction
        text: "Reload"
        iconName: "reload"
        onTriggered: {
            console.log("reload is clicked")
        }
    }

    Tabs {
        id: tabs
        Tab {
            title: i18n.tr("Simple page")
            page: Page {
                Label {
                    id: label
                    anchors.centerIn: parent
                    text: "A centered label"
                }
                tools: ToolbarItems {
                    ToolbarButton {
                        action: reloadAction
                    }
                }
            }
        }

        Tab {
            id: externalTab
            title: i18n.tr("External")

            page: Loader {
                id: loader
                anchors.fill: parent
                source: (tabs.selectedTab === externalTab) ? Qt.resolvedUrl("ExternalPage.qml") : ""

                onLoaded: {
                    console.log( loader.source + " is loaded")
                }
            }
        }

        Tab {
            title: i18n.tr("List view")
            page: Page {
                ListView {
                    clip: true
                    anchors.fill: parent
                    model: 20
                    delegate: ListItem.Standard {
                        iconName: "compose"
                        text: "Item "+modelData
                    }
                }
            }
        }
    }
}

