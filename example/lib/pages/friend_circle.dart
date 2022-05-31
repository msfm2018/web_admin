import 'package:flutter/material.dart';

class FriendCircle extends StatelessWidget {
  final FriendCircleViewModel? data;

  const FriendCircle({
    Key? key,
    this.data,
  }) : super(key: key);

  Widget renderComments() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      color: const Color(0xFFF3F3F5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: data!.comments!.map((comment) {
          return Text.rich(
            TextSpan(
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF333333),
              ),
              children: [
                TextSpan(
                  text: comment.fromUser,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF636F80),
                  ),
                ),
                TextSpan(text: '：${comment.content}'),
              ]..insertAll(
                  1,
                  comment.source!
                      ? [const TextSpan()]
                      : [
                          const TextSpan(text: ' 回复 '),
                          TextSpan(
                            text: comment.toUser,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF636F80),
                            ),
                          ),
                        ],
                ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              data!.userImgUrl!,
              width: 50,
              height: 50,
            ),
          ),
          const Padding(padding: EdgeInsets.only(left: 12)),
          SingleChildScrollView(
            primary: false,
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    data!.userName!,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF636F80),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 6)),
                  Text(
                    data!.saying!,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 0.8,
                      color: Color(0xFF333333),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Image.network(
                      data!.pic!,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        data!.publishTime!,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF999999),
                        ),
                      ),
                      const Icon(
                        Icons.comment,
                        size: 16,
                        color: Color(0xFF999999),
                      ),
                    ],
                  ),
                  renderComments(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FriendCircleViewModel {
  /// 用户名
  final String? userName;

  /// 用户头像地址
  final String? userImgUrl;

  /// 说说
  final String? saying;

  /// 图片
  final String? pic;

  ///发布时间
  final String? publishTime;

  /// 评论内容
  final List<Comment>? comments;

  const FriendCircleViewModel({
    this.userName,
    this.userImgUrl,
    this.saying,
    this.pic,
    this.publishTime,
    this.comments,
  });
}

class Comment {
  /// 是否发起人
  final bool? source;

  /// 评论者
  final String? fromUser;

  /// 被评论者
  final String? toUser;

  // 评论内容
  final String? content;

  const Comment({
    this.source,
    this.fromUser,
    this.toUser,
    this.content,
  });
}

/// 朋友圈mock数据
const FriendCircleViewModel friendCircleData = FriendCircleViewModel(
  userName: '小石头',
  userImgUrl: 'https://cdn2.jianshu.io/assets/default_avatar/13-394c31a9cb492fcb39c27422ca7d2815.jpg',
  saying: '听说Flutter很🔥，我也来凑热闹，github上建了一个仓库，欢迎来撩~✌✌✌',
  pic: 'https://cdn2.jianshu.io/assets/default_avatar/13-394c31a9cb492fcb39c27422ca7d2815.jpg',
  publishTime: '2小时前',
  comments: [
    Comment(source: true, fromUser: '若海', toUser: '小石头', content: '性能如何？'),
    Comment(source: false, fromUser: '小石头', toUser: '若海', content: '性能不错，但是开发体验感觉差一点。。。'),
    Comment(source: false, fromUser: '若海', toUser: '小石头', content: '周末我也试试，嘻嘻~'),
    Comment(source: true, fromUser: '大佬', toUser: '小石头', content: '卧槽，求求你别学了'),
    Comment(source: true, fromUser: '产品', toUser: '小石头', content: '工作量不饱和啊你这是！'),
    Comment(source: false, fromUser: '小石头', toUser: '大佬', content: '卧槽，大佬别闹，学不动了。。。'),
    Comment(source: false, fromUser: '小石头', toUser: '产品', content: '不不不，你的需求都已经完成了~！'),
  ],
);
