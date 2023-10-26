abstract class MainPaginateModel<T, P> {
   P? paginateInfo;
   List<T>? items;

   MainPaginateModel({
    this.items,
    this.paginateInfo,
   });
}
