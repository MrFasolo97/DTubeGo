# DTubeGo
DTubeGo is a mobile client to interact with the Avalon blockchain created in dart and flutter!

## Support me

This app required a lot of work, which I did for free because of my passion, but is likely to require more work.

So here is how you can support me and, indirectly, DTube with tips:

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/X8X5T1Q1D)

### Crypto

DTube account: `fasolo97`

BSC: `0x8a6A959B66a427F4a108c06bEb27388909EE00A5`

ETH: `0x6Ea63355551B9a137Cf8fd2b11545Cd9Dbe90A43`

WAVES: `3PJWu7qUo3byEbHesTsxe4i4SDP7Jp7n4ev`

Any kind of tip is appreciated, every bit matters.

## Table of contents
* [General Information](#general-information)
* [App Preview](#app-preview)
* [Technologies](#technologies)
* [Future plans](#future-plans)
* [Source Compilation](#source-compilation)
* [Contribution](#contribution)
* [Communication](#communication)

## General Information

The [Avalon Blockchain](https://github.com/dtube/avalon/) is a social media blockchain focusing on video sharing. The usual client for this blockchain is [DTube](https://d.tube) which is a javascript based website ([DTube repo here on github](https://github.com/dtube/dtube))

![](https://d.tube/DTube_files/images/DTube_Black.svg)

This is a flutter-based DTube client to interact with the Avalon blockchain. It includes most of the functionalities a user can do on the website but on a mobile device. 

## App Preview
Below is a list of a few features to give you an idea about how DTubeGo looks:
| **Feature** | **Example** | **Additional Information** |
|-------------|-------------|----------------------------|
| **5 different feeds**        |   ![](https://i.imgur.com/AZdMcqL.png)          |             DTubeGo currently offers 5 different feeds aimed at different target audiences. **Original Dtubers** (Only content posted by verified accounts) **New Feed** (all the recently posted content) **Following** (Only content of accounts the user follows) **Hot** (Content ranked by the [Avalon built-in "Hot-Algorithm"](https://github.com/dtube/avalon/blob/012713ca0729d2fe452b978fa2b51016402da324/src/rankings.js#L11)) **Trending** (Content ranked by the [Avalon built-in "Trending-Algorithm"](https://github.com/dtube/avalon/blob/012713ca0729d2fe452b978fa2b51016402da324/src/rankings.js#L15))
| **Genre explorer**        |      ![](https://i.imgur.com/HP4CAI2.png)       |     As an alternative to the basic feeds, the user can filter by several main tags to explore the Avalon Blockchain based on the user's interests. This list will continue to grow over time.                       |
| **Video details**        |        ![](https://i.imgur.com/bSQBpG9.png)     |            DtubeGo uses 2 different video players ([better_player](https://github.com/jhomlala/betterplayer) for videos stored on ipfs/sia and [youtube_player_iframe](https://github.com/sarbagyastha/youtube_player_flutter) for videos stored on youtube. Of course, the user can read the markdown description, comment, vote, and tip the content from here as well.                |
| **User details**        |       ![](https://i.imgur.com/9aQE1YS.png)      |     Here you can see all posts made by the account, follow and tip the creator. Additionally, we have implemented a  list of suggested users which is calculated by several factors. For example, tags used in the most recent videos compared with other content using those tags as well.                      |
| **Leaderboard**        |      ![](https://i.imgur.com/wZ6wpra.png)       |                 The leaderboard defines which node operating users are counting as block producers and earn rewards for their hosting.          |
| **Rewards**        |       ![](https://i.imgur.com/MJmk1JM.png)       |       The user can claim rewards within the app                     |
| **The DAO of Avalon**        |     ![](https://i.imgur.com/6E4xY9o.png)         |                    The DAO (decentralized autonomous organization) space of DTubeGo currently only supports voting and funding of proposals. Creating proposals can be done on [https://avalonblocks.com/#/governance](https://avalonblocks.com/#/governance).        |


## Technologies
This client is based on various API functions of the [avalon blockchain](https://github.com/dtube/avalon/). The blockchain is maintained by several independent `node leaders` on Avalon. They host one or more of the following components:
- Block-producing nodes
- observer nodes and 
- API nodes supplying the endpoints to interact with the blockchain.

The token of the Avalon blockchain is called DTube Coin. You can find more about the tokenomics and aspects of Avalon on the [Token page of DTube](https://token.d.tube/).

DTubeGo is created with:
* [Flutter](https://github.com/flutter/flutter) basic framework
* [flutter_bloc](https://github.com/felangel/bloc/tree/master/packages/flutter_bloc) state management
* [better_player](https://github.com/jhomlala/betterplayer) player for videos stored on IPFS or Sia network
* [youtube_player_iframe](https://github.com/sarbagyastha/youtube_player_flutter) player for videos stored on youtube
* [cached_network_image](https://github.com/Baseflow/flutter_cached_network_image) image caching for thumbnails and account avatars
* [video_compress](https://github.com/jonataslaw/VideoCompress) We compress videos uploaded with the app
* [flutter_secure_storage](https://github.com/mogol/flutter_secure_storage) the way we store application-related settings
* [flutter_markdown](https://github.com/flutter/packages/tree/main/packages/flutter_markdown) displaying markdown
* Various other cryptography and UI-related packages (see pubspec.yaml)
* 
## Future plans
You can find more planned changes in the [issues](https://github.com/dtube/DTubeGo/issues) of this repository.

## Source Compilation
We have a few files we can not push into this repository because they contain sensitive and secret values like API keys, decryption methods, and such. So if you clone this repo you will run into compilation issues and you will have to ask us for these files. We can give you those without the information manually via Discord (see [Communication](#communication)).

## Contribution
There is a [DAO for the Avalon Blockchain](https://avalonblocks.com/#/governance) on which every user can create proposals to get backing for their planned work from the community. Of course, you can also contribute as a volunteer.

## Communication
You can reach the developers, node leaders, and the community by joining the [DTube Discord Server](https://discord.gg/s6Z4UCb45k).

![](https://discord.com/assets/cb48d2a8d4991281d7a6a95d2f58195e.svg)

