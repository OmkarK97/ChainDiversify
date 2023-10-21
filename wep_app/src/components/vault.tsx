export default function Vault( props:any ) {
    return (
        <div className="px-4">
        <div className=" border-2 flex flex-col w-1/2 border-black divide-y divide-slate-700 p-4">
            <div>
                <div className=" flex justify-between p-2 items-center">
                        <div className=" h-6 flex justify-between">{props.title}</div>
                        <div>
                            Fee Tier
                            <div className=" h-6 flex justify-between">{props.fee}</div>
                        </div>
                </div>
                <div className=" p-2">
                    Stable Spread Strategy
                </div>
                    <div className="flex justify-center">
                        <div className="flex p-1">
                    <button type="button" className=" px-8 py-3 font-semibold rounded dark:bg-gray-100 dark:text-gray-800">Static Range</button>
                    <button type="button" className="px-8 py-3 font-semibold rounded dark:bg-gray-100 dark:text-gray-800">Stable Pair</button>
                        </div>
                        </div>
                </div>
                <div>
                    <div className="flex justify-between">
                        <div>
                            <div>TVL</div>
                            <div>83.12K/200K</div>
                        </div>
                        <div>
                            <div>LP APR</div>
                            <div>{ props.APR }</div>
                        </div>
                    </div>
            </div>
            </div>
        </div>
    )
}