import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_shop/data/comment.dart';
import 'package:flutter_online_shop/data/repo/comment_repository.dart';
import 'package:flutter_online_shop/ui/product/comment/bloc/commentlistbloc_bloc.dart';
import 'package:flutter_online_shop/ui/product/comment/comment.dart';
import 'package:flutter_online_shop/widgets/error.dart';

class CommentList extends StatelessWidget {
  final int productId;

  const CommentList({Key? key, required this.productId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final CommentListBloc bloc = CommentListBloc(
            repository: commentRepository, productId: productId);
        bloc.add(CommentListStarted());
        return bloc;
      },
      child: BlocBuilder<CommentListBloc, CommentListState>(
          builder: (context, state) {
        if (state is CommentListSuccess) {
          /*چون داخل کاستوم اسکرول ویو هستیم حتما باید از نوع اسلیور باشن ویجت ها */
          return SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              /* از اینجا به بعد شبیه لیست ویو عادی است */
              return CommentItem(
                comment: state.comments[index],
              );
            }, childCount: state.comments.length),
          );
        } else if (state is CommentListLoading) {
          /*تبدیل ویجت های عادی به اسلیور -> اگر ویجتی داشته باشیم که خودش از نوع اسلیور است نیازی بهش نداریم  */
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is CommentListError) {
          return SliverToBoxAdapter(
            child: AppErrorWidget(
              exception: state.exception,
              onPressed: () {
                BlocProvider.of<CommentListBloc>(context)
                    .add(CommentListStarted());
              },
            ),
          );
        } else {
          throw Exception('state is not supported');
        }
      }),
    );
  }
}
